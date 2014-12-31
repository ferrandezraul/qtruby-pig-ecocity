require 'Qt'

class DateDialog < Qt::Dialog

  slots 'accept()', 'reject()'

  attr_reader :dateEdit

  def initialize( parent = nil )
    super( parent )

    @label = Qt::Label.new

    @dateEdit = Qt::DateEdit.new

    @buttonBox = Qt::DialogButtonBox.new

    @buttonBox.standardButtons = Qt::DialogButtonBox::Cancel|Qt::DialogButtonBox::Ok

    self.layout = Qt::VBoxLayout.new do |g|
      g.addWidget(@label)
      g.addWidget(@dateEdit)
      g.addWidget(@buttonBox)
    end

    connect(@buttonBox, SIGNAL('accepted()'), self, SLOT('accept()'))
    connect(@buttonBox, SIGNAL('rejected()'), self, SLOT('reject()'))
  end

  def get_date
    @dateEdit.to_s
  end

end

