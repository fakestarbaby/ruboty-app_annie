module Ruboty
  module AppAnnie
    module Actions
      class ListProducts < Base
        def call
          list_products
        end

        private

        def list_products
          message.reply(products.join("\n"), code: true)
        end

        def products
          client.products(given_account_id).body.products.select{ |p| p.status }.map do |product|
            "ID: #{product.product_id}, Name: #{product.product_name}"
          end
        end

        def given_account_id
          message[:account_id]
        end
      end
    end
  end
end
