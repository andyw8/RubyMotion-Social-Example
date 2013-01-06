class MenuController < UITableViewController
  def viewDidLoad
    super
    @options = ['Compose', 'Sign In']
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
    if indexPath.row == 0
      compose
    else
      sign_in
    end
  end

  private

  def compose
    @composer = Composer.new self
  end

  def sign_in
    NSLog 'Sign In'
  end
end
