require 'products_tree_model'

class ProductsTab < Qt::Widget

  def initialize( products, parent = nil )
    super(parent)

    data = "Designing a Component			Creating a GUI for your application\n"
    data << "Creating a Dialog			How to create a dialog"
    data << "Composing the Dialog		Putting widgets into the dialog example"
    data << "Creating a Layout			Arranging widgets on a form"
    data << "Signal and Slot Connections		Making widget communicate with each other"

    data << "Using a Component in Your Application	Generating code from forms"
    data << "The Direct Approach			Using a form without any adjustments"
    data << "The Single Inheritance Approach	Subclassing a form's base class"
    data << "The Multiple Inheritance Approach	Subclassing the form itself"
    data << "Automatic Connections		Connecting widgets using a naming scheme"
    data << "A Dialog Without Auto-Connect	How to connect widgets without a naming scheme"
    data << "A Dialog With Auto-Connect	Using automatic connections"

    data << "Form Editing Mode			How to edit a form in Qt Designer"
    data << "Managing Forms			Loading and saving forms"
    data << "Editing a Form			Basic editing techniques"
    data << "The Property Editor			Changing widget properties"
    data << "The Object Inspector		Examining the hierarchy of objects on a form"
    data << "Layouts				Objects that arrange widgets on a form"
    data << "Applying and Breaking Layouts	Managing widgets in layouts"
    data << "Horizontal and Vertical Layouts	Standard row and column layouts"
    data << "The Grid Layout			Arranging widgets in a matrix"
    data << "Previewing Forms			Checking that the design works"


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