class MenuController < UITableViewController
  def viewDidLoad
    super
    @options = [
      "Post to Twitter",
      "Post to Facebook",
      "Post to Sina Weibo",
      "Auto-post to Twitter"
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
      auto
    else
      raise
    end
  end

  private

  def compose(service)
    @composer = Composer.new self, service
  end

  def auto
    @auto = Auto.new
  end
end
