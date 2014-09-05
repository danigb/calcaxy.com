module BasicHelpers
  def active_if_current(path)
    current_page.url == path ? 'active' : ''
  end

  def calc_view
    @view ||= CalcaxyView.new
  end

  class CalcaxyView
    MIN_YEAR = 1990
    MAX_YEAR = 2008
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

    def valid_year?(string)
      year = string.to_i
      year < MIN_YEAR || year > MAX_YEAR
    end

    def booc_parent(year)
      Page.find_by_title(year, :conditions => ['parent_id = ?', PAGE_BOOC])
    end

    def booc_years
      years = (MIN_YEAR..MAX_YEAR).to_a.reverse!
      years.delete(2006)
      years
    end
  end

end
