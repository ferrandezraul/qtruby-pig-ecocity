require 'products_tree_model'

class ProductsTab < Qt::Widget

  def initialize( products, parent = nil )
    super(parent)

    products_model = ProductsTreeModel.new( products )

    view = Qt::TreeView.new
    view.model = products_model
    view.windowTitle = "Simple Tree Model"
    view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( view )

      # Add spacer
      #m.addStretch( 1 )
    end

  end
end