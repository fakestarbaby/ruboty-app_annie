module Ruboty
  module AppAnnie
    module Actions
      class ListReviews < Base
        def call
          initialize_date_conditions

          case
          when !exists_reviews?
            return true
          else
            list_reviews
          end
        end

        private

        def exists_reviews?
          !reviews.empty?
        end

        def list_reviews
          message.reply(reviews.join("\n\n"))
        end

        def initialize_date_conditions
          days_ago = Date.today.ago(given_days_ago.to_i.days).to_date.to_s
          @start_date = days_ago
          @end_date = days_ago
        rescue IndexError
        end

        def reviews
          reply_reviews = []
          if given_product_id.nil?
            client.products(account.account_id).body.products.select{ |p| p.status }.map do |p|
              reply_reviews << product_reviews(p.product_id, p.product_name)
            end
          else
            product = product(given_product_id)
            reply_reviews = product_reviews(product.product_id, product.product_name)
          end
          reply_reviews
        end

        def product_reviews(product_id, product_name)
          client.product_reviews(market, product_id, given_start_date, given_end_date, given_country).body.reviews.map do |review|
            "#{market_string(market)} #{product_name} #{version_string(review)}\n" + "> #{rating_string(review)}#{title_string(review)}\n" + "> ```#{review.text}```"
          end
        end

        def account
          client.accounts.body.accounts.select { |a| a.market == market }.first
        end

        def product(product_id)
          client.product_details(market, product_id).body.product
        end

        def market_string(market)
          case market
          when "ios" then ios_string
          when "google-play" then android_string
          end
        end

        def ios_string
          ENV["APP_ANNIE_IOS_STRING"] || "iOS:"
        end

        def android_string
          ENV["APP_ANNIE_ANDROID_STRING"] || "Android:"
        end

        def version_string(review)
          review.version.nil? ? "" : "- v#{review.version}"
        end

        def rating_string(review)
          (positive_star_string * review.rating) + (negative_star_string * (5 - review.rating))
        end

        def positive_star_string
          ENV["APP_ANNIE_POSITIVE_STAR_STRING"] || "★"
        end

        def negative_star_string
          ENV["APP_ANNIE_NEGATIVE_STAR_STRING"] || "☆"
        end

        def title_string(review)
          review.title.nil? ? "" : " / *#{review.title}*"
        end

        def market
          case given_market
          when "ios" then "ios"
          when "android" then "google-play"
          end
        end

        def given_market
          message[:market]
        end

        def given_product_id
          message[:product_id]
        rescue IndexError
          nil
        end

        def given_start_date
          @start_date ||= message[:start_date]
        end

        def given_end_date
          @end_date ||= message[:end_date]
        end

        def given_days_ago
          message[:days_ago]
        end

        def given_country
          message[:country]
        end
      end
    end
  end
end
