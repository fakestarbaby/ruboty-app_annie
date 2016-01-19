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

      def list_accounts(message)
        Ruboty::AppAnnie::Actions::ListAccounts.new(message).call
      end

      def list_products(message)
        Ruboty::AppAnnie::Actions::ListProducts.new(message).call
      end
    end
  end
end
