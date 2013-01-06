class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    menu_controller = MenuController.alloc.init
    navigation_controller = UINavigationController.alloc.initWithRootViewController(menu_controller)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigation_controller
    @window.makeKeyAndVisible
    true
  end
end
