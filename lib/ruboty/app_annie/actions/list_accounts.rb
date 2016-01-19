module Ruboty
  module AppAnnie
    module Actions
      class ListAccounts < Base
        def call
          list_accounts
        end

        private

        def list_accounts
          message.reply(accounts, code: true)
        end

        def accounts
          client.accounts.body.accounts.map do |account|
            "ID: #{account.account_id}, Market: #{account.market}, Name: #{account.account_name}"
          end
        end
      end
    end
  end
end
