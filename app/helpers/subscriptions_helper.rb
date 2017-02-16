module SubscriptionsHelper
  include Redmine::Export::PDF
  include Redmine::Export::PDF::IssuesPdfHelper

  def key_types
    [[t('activerecord.models.password'),'Vault::Password'], [t('activerecord.models.key_file'),'Vault::KeyFile']]
  end

  def subscriptions_to_pdf(subscriptions, project, query)
    pdf = ITCPDF.new(current_language, "L")
    title = "#{project}"
    pdf.set_title(title)
    pdf.alias_nb_pages
    pdf.footer_date = format_date(Date.today)
    pdf.set_auto_page_break(false)
    pdf.add_page("L")

    # Landscape A4 = 210 x 297 mm
    page_height   = pdf.get_page_height # 210
    page_width    = pdf.get_page_width  # 297
    left_margin   = pdf.get_original_margins['left'] # 10
    right_margin  = pdf.get_original_margins['right'] # 10
    bottom_margin = pdf.get_footer_margin
    row_height    = 4

    # column widths
    table_width = page_width - right_margin - left_margin

    # title
    pdf.SetFontStyle('B',11)
    pdf.RDMCell(190,10, title)
    pdf.ln

    pdf.RDMMultiCell(100,row_height,t('activerecord.models.subscription.name'),1,"",0,0)
    pdf.RDMMultiCell(100,row_height,t('activerecord.models.subscription.hours'),1,"",0,0)
    pdf.RDMMultiCell(30,row_height,t('activerecord.models.subscription.begindate'),1,"",0,0)
    pdf.RDMMultiCell(50,row_height,t('activerecord.models.subscription.enddate'),1,"",0,1)

    pdf.SetFontStyle('',8)

    subscriptions.each { |subscription|
      base_y = pdf.get_y
      subscription.name = "-" if subscription.name == nil
      subscription.hours = "-" if subscription.hours == nil
      subscription.begindate = "-" if subscription.begindate == nil
      subscription.enddate = "-" if subscription.enddate == nil

      pdf.RDMMultiCell(100,row_height,subscription.name.to_s,1,"",0,0)
      pdf.RDMMultiCell(100,row_height,subscription.hours.to_s,1,"",0,0)
      pdf.RDMMultiCell(30,row_height,subscription.begindate.to_s,1,"",0,0)
      pdf.RDMMultiCell(50,row_height,subscription.enddate.to_s,1,"",0,1)

      max_height = 6*row_height
      space_left = page_height - base_y - bottom_margin

      if max_height > space_left
        pdf.add_page("L")
        base_y = pdf.get_y
      end

    }

    pdf.output
  end

end
