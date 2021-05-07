module PhotoMosaic
  class ProgressBar
    def image_import(event)
      @image_count ||= event[:paths].size
      @import_progress_bar ||= ::ProgressBar.create(
        total: @image_count,
        length: 150,
        format: "%a %e %P% Processed: %c/%C %t"
      )
      @import_progress_bar.title = "Importing tile images: " + event[:current_path]
      @import_progress_bar.increment
      system("clear") if @import_progress_bar.finished?
    end

    def image_find_match(event)
      @mosaic_size ||= event[:total]
      @mosaic_progress_bar ||= ::ProgressBar.create(
        total: @mosaic_size,
        length: 150,
        format: "%a %e %P% Processed: %c/%C tiles %t: |\e[0;34m%B\e[0m|"
      )
      @mosaic_progress_bar.title = "Finding matches"
      @mosaic_progress_bar.increment
    end
  end
end
