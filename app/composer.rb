class Composer
  def initialize(owner, service, initial_text)
    service = services.fetch service

    if SLComposeViewController.isAvailableForServiceType service
      @controller = SLComposeViewController.composeViewControllerForServiceType service

      @controller.completionHandler = lambda do |result|
        if result == SLComposeViewControllerResultCancelled
          NSLog "Cancelled"
        else
          NSLog "Done"
        end
        @controller.dismissViewControllerAnimated true, completion:nil
      end

      result = @controller.setInitialText initial_text
      unless result
        NSLog "Failure when setting initial text"
      end

      owner.presentViewController @controller, animated:true, completion:nil
    else
      NSLog "Unavailable"
    end
  end

  private

  def services
    {
      'Twitter' => SLServiceTypeTwitter,
      'Facebook' => SLServiceTypeFacebook,
      'Sina Weibo' => SLServiceTypeSinaWeibo
    }
  end
end
