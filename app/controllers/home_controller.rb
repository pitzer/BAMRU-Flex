require Rails.root + 'lib/csv_generator'

class HomeController < ApplicationController

  def index
    @images = header_images()
  end

  def calendar
    @start = Time.now
    @finish = Time.now + 1.year
    respond_to do |format|
      format.html
      format.csv
      #format.gcal
      #format.ical
    end
  end

  def alt
    if params['page'].nil?
      render 'index'
    else
      render params['page']
    end
  end

  private

  def image_file(path)
    return nil if path.nil?
    file = "images/page_gallery/#{path}.jpg"
    File.exist?("public/#{file}") ? file : nil
  end

  def header_images(lead_image = nil)
    header_image = image_file(lead_image)
    files = Dir.glob('public/images/static_gallery/*').sort.map do |path|
      path.gsub('public/', '')
    end
    header_image.nil? ? files : files.unshift(header_image)
  end

end
