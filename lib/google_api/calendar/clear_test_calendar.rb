# frozen_string_literal: true

class GoogleAPI
  class Calendar < GoogleAPI::Base
    module ClearTestCalendar
      def clear_test_calendar(page_token: nil, page_limit: 50, verbose: false, error: false)
        raise Google::Apis::RateLimitError, '(Rate Limit Exceeded)' if error

        @verbose = verbose
        quietly do
          choose_page_token(page_token)
          loop_over_pages(ENV['GOOGLE_CALENDAR_ID_TEST'], page_limit: page_limit)
        end
        puts '*** Cleared all events!' if @verbose
      rescue Google::Apis::RateLimitError
        puts "\n\n*** Google::Apis::RateLimitError (Rate Limit Exceeded)" if @verbose
      ensure
        log_last_page_token if token?
      end

    private

      def quietly
        old_level = Google::Apis.logger.level
        Google::Apis.logger.level = Logger::WARN

        yield

        Google::Apis.logger.level = old_level
      end

      def choose_page_token(page_token)
        last_token = Calendar.last_token_path
        @page_token ||= File.read(last_token) if File.exist?(last_token)
        @page_token = page_token if token?(page_token)
      end

      def token?(token = nil)
        token ||= @token
        token != ''
      end

      def loop_over_pages(cal_id, page_limit: 50)
        puts "*** Starting with page token: #{@page_token}" if @verbose && token?

        page_limit -= 1 while (@page_token = clear_page(cal_id)) && page_limit.positive?
      end

      def clear_page(cal_id)
        response = list(cal_id, page_token: @page_token)
        clear_events_from_page(cal_id, response.items) unless response.items.empty?
        response.next_page_token
      end

      def clear_events_from_page(cal_id, items)
        puts "*** Page token: #{@page_token}" if @verbose
        pb = progress_bar(items.count) if @verbose
        items&.each_with_index do |event, _index|
          ExpRetry.for(exception: Calendar::RETRIES) do
            delete(cal_id, event.id)
            pb.increment if @verbose
          end
        end
      end

      def log_last_page_token
        puts "\n\n*** Last page token cleared: #{@page_token}" if @verbose
        File.open(Calendar.last_token_path, 'w+') { |f| f.write(@page_token) }
        puts "\n*** Token stored in #{Calendar.last_token_path}" if @verbose
      end

      def progress_bar(total)
        bar_config = {
          title: 'Page cleared', starting_at: 0, total: total, progress_mark: ' ',
          remainder_mark: "\u{FF65}", format: "%a [%R/sec] %E | %b\u{15E7}%i %c/%C (%P%%) %t"
        }

        bar_config = bar_config.merge(output: ProgressBar::Silent) if ENV.key?('HIDE_PROGRESS_BARS')

        ProgressBar.create(bar_config)
      end
    end
  end
end
