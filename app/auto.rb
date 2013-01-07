class Auto
  def initialize(type)
    @type = type
    @account_store = ACAccountStore.alloc.init
    @account_type = @account_store.accountTypeWithAccountTypeIdentifier type
  end

  def post_status(status)
    @status = status
    error_ptr = Pointer.new(:object)
    @account_store.requestAccessToAccountsWithType @account_type, options:options, completion: lambda { |granted, error_ptr|
      if granted
        accounts = @account_store.accountsWithAccountType @account_type
        raise "No accounts" if accounts.empty? # I don't think should ever happen

        # For the sake of brevity, we'll assume there is only one Twitter account present.
        # You would ideally ask the user which account they want to tweet from, if there is
        # more than one Twitter account present.

        # Grab the initial Twitter account to tweet from.
        account = accounts.first

        url = NSURL.URLWithString "https://api.twitter.com/1.1/statuses/update.json"
        params = { status: @status }
        post_request = TWRequest.alloc.initWithURL url, parameters:params, requestMethod:TWRequestMethodPOST

        post_request.account = account

        # Perform the request created above and create a handler block to handle the response.
        post_request.performRequestWithHandler lambda { |response_data, url_response, error|
          NSLog "HTTP response status: #{url_response.statusCode}"
        }
      else
        NSLog "Not Granted"
        handle_error error_ptr
      end
    }
  end

  def options
    if @type == ACAccountTypeIdentifierFacebook
      {
        ACFacebookAppIdKey: 142117789275997,
        CFacebookPermissionsKey: ["email", "publish_stream"],
        ACFacebookAudienceKey: ACFacebookAudienceOnlyMe
      }
    else # only Facebook needs options
      nil
    end
  end

  def handle_error(error_ptr)
    case error_ptr.code
    when ACErrorUnknown
      NSLog "Error Unknown"
    when ACErrorAccountMissingRequiredProperty
      NSLog "Account missing required property"
    when ACErrorAccountAuthenticationFailed
      NSLog "Account authentication failed"
    when ACErrorAccountTypeInvalid
      NSLog "Account type invalid"
    when ACErrorAccountAlreadyExists
      NSLog "Account already exists"
    when ACErrorAccountNotFound
      # Occurs if the user has no accounts set up of the particular type
      NSLog "Account not found"
    when ACErrorPermissionDenied
      NSLog "User denied permission"
    when ACErrorAccessInfoInvalid
      NSLog "Access info invalid"
    else
      NSLog "Unknown error code"
    end
  end
end
