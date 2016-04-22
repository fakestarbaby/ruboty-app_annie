module Ruboty
  module Handlers
    class AppAnnie < Base
      env :APP_ANNIE_API_KEY, "APP_ANNIE_API_KEY - App Annie API Key"

      on(
        /annie list accounts\z/,
        name: "list_accounts",
        description: "Retrieve all account connections available in an App Annie user account",
      )

      on(
        /annie list products of (?<account_id>.+)\z/,
        name: "list_products",
        description: "Retrieve the product list of an Analytics Account Connection",
      )

      on(
        /annie list (?<market>ios|android) reviews of (?<product_id>.+) from (?<start_date>.+) to (?<end_date>.+) in (?<country>.+)\z/,
        name: "list_reviews",
        description: "Retrieve one product's reviews",
      )

      on(
        /annie list (?<market>(?:ios|android)) reviews of (?<product_id>.+) days ago (?<days_ago>.+) in (?<country>.+)\z/,
        name: "list_reviews_of_days_ago",
        description: "Retrieve one product'’'s reviews of days ago",
      )

      def list_accounts(message)
        Ruboty::AppAnnie::Actions::ListAccounts.new(message).call
      end

      def list_products(message)
        Ruboty::AppAnnie::Actions::ListProducts.new(message).call
      end

      def list_reviews(message)
        Ruboty::AppAnnie::Actions::ListReviews.new(message).call
      end

      def list_reviews_of_days_ago(message)
        Ruboty::AppAnnie::Actions::ListReviews.new(message).call
      end
    end
  end
end
