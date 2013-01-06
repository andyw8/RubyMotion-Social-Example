class MenuController < UITableViewController
  def viewDidLoad
    super
    @options = []
    @options << "Post to Twitter"
    @options << "Post to Facebook"
    @options << "Post to Sina Weibo"
    @options << "Auto-post to Twitter"
    self.title = "Social"
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @options.size
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    cellIdentifier = self.class.name
    cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:cellIdentifier)
    cell.textLabel.text = @options[indexPath.row]
    cell
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
      sign_in
    else
      raise
    end
  end

  private

  def compose(service)
    @composer = Composer.new self, service
  end

  def sign_in
    @auto = Auto.new
  end
end
