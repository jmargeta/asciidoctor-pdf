require 'rghost'

module Asciidoctor
module PDF
class Optimizer
  def initialize quality = 'default', compatibility_level = '1.4'
    @quality = quality.empty? ? :default : quality.to_sym
    @compatibility_level = compatibility_level
  end

  def generate_file target
    filename_o = (filename = Pathname.new target).sub_ext '-o.pdf'
    pdfmark = filename.sub_ext '.pdfmark'
    (::RGhost::Convert.new target).to :pdf,
      filename: filename_o.to_s,
      quality: @quality,
      d: { Printed: false, CannotEmbedFontPolicy: '/Warning', CompatibilityLevel: @compatibility_level },
      raw: pdfmark.file? ? pdfmark.to_s : nil
    filename_o.rename target
  end
end
end
end