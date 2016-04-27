module Ruboty
  module AppAnnie
    module Actions
      class ListRanks < Base
        def call
          initialize_date_conditions

          case
          when !exists_ranks?
            return true
          else
            list_ranks
          end
        end

        private

        def exists_ranks?
          !ranks.empty?
        end

        def list_ranks
          message.reply(ranks.join("\n"))
        end

        def initialize_date_conditions
          days_ago = Date.today.ago(given_days_ago.to_i.days).to_date.to_s
          @start_date = days_ago
          @end_date = days_ago
        rescue IndexError
        end

        def ranks
          reply_ranks = []
          client.products(account.account_id).body.products.select{ |p| p.status }.map do |p|
            reply_rank = product_ranks(p.product_id, p.product_name)
            reply_ranks << reply_rank unless reply_rank.nil?
          end
          reply_ranks
        end

        def product_ranks(product_id, product_name)
          response = client.product_ranks(market, product_id, given_start_date, given_end_date, given_country, given_category, given_feed).body.product_ranks
          return if response.empty?

          response.first.ranks.map do |key, value|
            "#{market_string(market)} #{key} #{value} #{product_name}"
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

        def market
          case given_market
          when "ios" then "ios"
          when "android" then "google-play"
          end
        end

        def given_market
          message[:market]
        end

        def given_feed
          message[:feed]
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

        def given_category
          message[:category]
        end
      end
    end
  end
end
