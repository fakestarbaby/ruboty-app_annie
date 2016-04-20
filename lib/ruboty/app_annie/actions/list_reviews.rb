module Ruboty
  module AppAnnie
    module Actions
      class ListReviews < Base
        def call
          list_reviews if exists_reviews?
        end

        private

        def list_reviews
          message.reply(reviews.join("\n\n"))
        end

        def exists_reviews?
          !reviews.empty?
        end

        def reviews
          @reviews ||= client.product_reviews(market, given_product_id, given_start_date, given_end_date, given_country).body.reviews.map do |review|
            "#{market_string(market)} #{product.product_name} #{version_string(review)}\n" + "> #{rating_string(review)}#{title_string(review)}\n" + "> ```#{review.text}```"
          end
        end

        def product
          @product ||= client.product_details(market, given_product_id).body.product
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
        end

        def given_start_date
          message[:start_date]
        end

        def given_end_date
          message[:end_date]
        end

        def given_country
          message[:country]
        end
      end
    end
  end
end
