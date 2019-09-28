
    PDFKit.configure do |config|
      config.wkhtmltopdf = 'PATH/TO/wkhtmltopdf'

      config.default_options = {
        encoding:"UTF-8",
        dpi: '300',
        margin_top: '100',
        margin_bottom: '23',
        margin_left: '10',
        margin_right: '10',
        header_spacing: '0',
        # header_html: render_header_footer("header"),
        footer_spacing: '2',
        # footer_html: render_header_footer("footer"),
        quiet: true,
        # :"user-style-sheet" => "#{Rails.root}/app/assets/stylesheets/pdfkit.scss"
      }

       # Use only if your external hostname is unavailable on the server.
  config.root_url = "http://localhost"
  config.verbose = false
    end



  # Render the footer out to a temp file
  # PDFkit will only accept a file or URL, it will not accept raw text the way you expect.
  # ie; passing the erb compiled output directly back to pdfkit results in non-dynamic content being displayed.
  # def render_header_footer(type)
  #   compiled = ERB.new(File.read("#{Rails.root}/app/views/shared/#{type}.html.erb")).result(binding)
  #   file = Tempfile.new(["#{type}",".html"])
  #   file.write(compiled)
  #   file.rewind
  #   file.path
  # end

  # config
