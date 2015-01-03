require 'Qt'

class ProductOptionsDialog < Qt::Dialog

  slots 'accept()', 'reject()'

  def initialize( options, weight, parent = nil )
    super( parent )

    @weight = weight

    self.windowTitle = "Selecciona opcions fins #{weight} Kg"

    @product_options_entries = options.map do |option|
      check_box = Qt::CheckBox.new
      option_label = Qt::Label.new( "#{option.quantity} x #{option.weight} #{option.name}" )
      [ check_box, option_label, option]
    end

    @button_box = Qt::DialogButtonBox.new
    @button_box.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      @product_options_entries.each do | checkbox, label, option |
        h_layout = Qt::HBoxLayout.new do |m|
          m.addWidget(checkbox)
          m.addWidget(label)
        end
        g.addLayout(h_layout)
      end

      g.addWidget(@button_box)
    end

    connect(@button_box, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@button_box, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def get_options
    options_selected = Array.new

    @product_options_entries.map do |checkbox, label, option|
      options_selected << option if checkbox.checked?
    end

    options_selected
  end

end

