class ProductsTab < Qt::Widget

  def initialize( products_model, parent = nil )
    super(parent)

    view = Qt::TreeView.new
    view.model = products_model
    view.windowTitle = 'Products Tree Model'
    view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( view )

      # Add spacer
      #m.addStretch( 1 )
    end

  end

end