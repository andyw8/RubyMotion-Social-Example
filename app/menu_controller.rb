class MenuController < UITableViewController
  def viewDidLoad
    super
    @options = [
      "Compose Twitter post",
      "Compose Facebook post",
      "Compose Sina Weibo post",
      "Auto-post to Twitter",
      "Auto-post to Facebook",
      "Auto-post to Sina Weibo"
    ]
    self.title = "Social"
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @options.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:nil).tap do |cell|
      cell.textLabel.text = @options[indexPath.row]
    end
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    case indexPath.row
    when 0
      compose 'Twitter'
    when 1
      compose 'Facebook'
    when 2
      compose 'Sina Weibo'
    when 3
      auto ACAccountTypeIdentifierTwitter
    when 4
      auto ACAccountTypeIdentifierFacebook
    when 5
      auto ACAccountTypeIdentifierSinaWeibo
    else
      raise
    end
  end

  private

  def compose(service)
    @composer = Composer.new self, service, "Test post from RubyMotion"
  end

  def auto(type)
    @auto = Auto.new(type)
  end
end
