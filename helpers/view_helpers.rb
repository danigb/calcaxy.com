module ViewHelpers
  def calc_view
    @view ||= CalcaxyView.new
  end

  class CalcaxyView

    PAGE_HOME = 1
    PAGE_BOOC = 2
    PAGE_BIO = 216
    PAGE_TXT = 20

    def home
      @home ||= Repo.find('Page', 1)
    end

    def metas
      @metas ||= Repo.all('Meta').select {|m| m.page_id.to_i == 1 }
    end

    def works
      @works ||= Repo.all('Page').select {|p| p.mime == 'file'}.sort_by! {|p| p.position}
      #Page.find_all_by_mime('file', :order => 'position')
    end

    def booc_parent(year)
      Repo.all('Page').find { |p| p.parent_id.to_i == PAGE_BOOC && p.title == year.to_s }
    end
  end

end