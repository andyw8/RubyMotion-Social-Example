class Auto
  def initialize
    # Create an account store object.
    @account_store = ACAccountStore.alloc.init

    # Create an account type that ensures Twitter accounts are retrieved.
    @account_type = @account_store.accountTypeWithAccountTypeIdentifier ACAccountTypeIdentifierTwitter

    # Request access from the user to use their Twitter accounts.
    options = nil # required for some account types but not Twitter
    error_ptr = Pointer.new(:object)
    @account_store.requestAccessToAccountsWithType @account_type, options:options, completion: lambda { |granted, error_ptr|
      if granted
        # Get the list of Twitter accounts.
        accounts = @account_store.accountsWithAccountType @account_type

        # For the sake of brevity, we'll assume there is only one Twitter account present.
        # You would ideally ask the user which account they want to tweet from, if there is
        # more than one Twitter account present.

        raise "No accounts" if accounts.empty? # I don't think should ever happen

        # Grab the initial Twitter account to tweet from.
        account = accounts.first

        # Create a request, which in this example, posts a tweet to the user's timeline.
        # This example uses version 1 of the Twitter API.
        # This may need to be changed to whichever version is currently appropriate.

        url = NSURL.URLWithString "http://api.twitter.com/1.1/statuses/update.json"
        params = { status: "Test post from iOS" }
        post_request = TWRequest.alloc.initWithURL url, parameters:params, requestMethod:TWRequestMethodPOST

        # Set the account used to post the tweet.
        post_request.account = account

        # Perform the request created above and create a handler block to handle the response.
        post_request.performRequestWithHandler lambda { |response_data, url_response, error|
          NSLog "HTTP response status: #{url_response.statusCode}"
        }
      else
        NSLog "Not Granted"
        case error_ptr.code
        when ACErrorUnknown
          NSLog "Unknown error"
        when ACErrorAccountMissingRequiredProperty
          NSLog "Account Missing Required Property"
        when ACErrorAccountAuthenticationFailed
          NSLog "Account Authentication Failed"
        when ACErrorAccountTypeInvalid
          NSLog "Account Type Invalid"
        when ACErrorAccountAlreadyExists
          NSLog "Account Already Exists"
        when ACErrorAccountNotFound
          # Occurs if the user has no accounts set up of the particular type
          NSLog "Account Not Found"
        when ACErrorPermissionDenied
          NSLog "User denied permission"
        when ACErrorAccessInfoInvalid
          NSLog "Access Info Invalid"
        else
          NSLog "Unknown error code"
        end
      end
    }
  end
end
