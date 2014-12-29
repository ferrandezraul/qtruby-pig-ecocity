require 'products_tree_model'

class ProductsTab < Qt::Widget

  def initialize( products, parent = nil )
    super(parent)

    data = "Designing a Component			Creating a GUI for your application" +
    "Creating a Dialog			How to create a dialog" +
    "Composing the Dialog		Putting widgets into the dialog example" +
    "Creating a Layout			Arranging widgets on a form" +
    "Signal and Slot Connections		Making widget communicate with each other" +

    "Using a Component in Your Application	Generating code from forms" +
    "The Direct Approach			Using a form without any adjustments" +
    "The Single Inheritance Approach	Subclassing a form's base class" +
    "The Multiple Inheritance Approach	Subclassing the form itself" +
    "Automatic Connections		Connecting widgets using a naming scheme" +
    "A Dialog Without Auto-Connect	How to connect widgets without a naming scheme" +
    "A Dialog With Auto-Connect	Using automatic connections" +

    "Form Editing Mode			How to edit a form in Qt Designer" +
    "Managing Forms			Loading and saving forms" +
    "Editing a Form			Basic editing techniques" +
    "The Property Editor			Changing widget properties" +
    "The Object Inspector		Examining the hierarchy of objects on a form" +
    "Layouts				Objects that arrange widgets on a form" +
    "Applying and Breaking Layouts	Managing widgets in layouts" +
    "Horizontal and Vertical Layouts	Standard row and column layouts" +
    "The Grid Layout			Arranging widgets in a matrix" +
    "Previewing Forms			Checking that the design works"


    products_model = ProductsTreeModel.new( data )

    view = Qt::TreeView.new
    view.model = products_model
    view.windowTitle = "Simple Tree Model"
    view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( view )
      m.addStretch( 1 )
    end

  end
end