class CustomersTab < Qt::Widget

  def initialize( customers_model, parent = nil )
    super(parent)

    view = Qt::TreeView.new
    view.model = customers_model
    view.windowTitle = 'Customers Tree Model'
    view.show

    self.layout = Qt::VBoxLayout.new do |m|
      m.addWidget( view )

      # Add spacer
      #m.addStretch( 1 )
    end

  end

end