class OrdersTab < Qt::Widget

  def initialize( orders_model, parent = nil )
    super(parent)

    view = Qt::TreeView.new
    view.model = orders_model
    view.windowTitle = 'Orders Tree Model'
    view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( view )

      # Add spacer
      #m.addStretch( 1 )
    end

  end

end