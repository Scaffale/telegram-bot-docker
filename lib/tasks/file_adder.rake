require "#{Rails.root}/app/helpers/ffmpeg_helper"
include FfmpegHelper

namespace :file_adder do
  desc 'Compress and codec files to .ogg (from to_convert folder into data folder). Codec is very slow (usually around 0.35x)'
  task :compress do
    folder_to_convert = 'to_convert'
    videos = all_videos(folder_name: folder_to_convert)
    bar = ProgressBar.create(total:videos.count, progress_mark: '#', remainder_mark: '-')
    Parallel.each(videos) do |file_name|
      # p "Converto: #{file_name}"
      file_name_clean = file_name_without_extension(file_name)
      # comando per comprimerla bene in webm (stralento)
      comand = "ffmpeg -n -loglevel warning -i #{Rails.root.join(folder_to_convert, file_name)} -an -crf 32 -vf \"subtitles=#{Rails.root.join(folder_to_convert, file_name_clean)}.srt:force_style='Fontsize=28', scale=trunc(oh*a/2)*2:480, fps=24\" #{Rails.root.join('data', file_name_clean)}.webm"
      # comando per comprimerla bene in mp4 e vedere se i sottotitoli sono giusti (veloce)
      # speed = 'veryslow'
      # comand = "ffmpeg -n -loglevel info -i #{Rails.root.join('data', file_name)} -codec:v libx264 -preset #{speed} -an -crf 32 -vf \"subtitles=#{Rails.root.join('data', file_name_clean)}.srt:force_style='Fontsize=28', scale=trunc(oh*a/2)*2:480, fps=24\" #{Rails.root.join('data', file_name_clean)}_#{speed}.mp4"
      system(comand)
      bar.increment
    end
    p "You should probably run rails db:seed (with the subtitles files in #{folder_to_convert} folder)"
  end

  desc 'Compress files in to_convert folder (no overwrite), then run db:seed. No files are deleted or data overwited.'
  task :full do
    p '@' * 100
    p ENV['SKIP_FILE_CONVERSION']
    p ENV['SKIP_FILE_CONVERSION'] == 'true'
    p ENV['SKIP_FILE_CONVERSION'] == true
    p '$' * 100
    return if ENV['SKIP_FILE_CONVERSION'] == 'true'
    Rake::Task["file_adder:compress"].invoke
    Rake::Task["db:seed"].invoke
  end

  namespace :subtitles do
    desc 'Extract subtitles, select channel (0, 1, 2...) depending on file'
    task :out, [:channel] do |_t, args|
      all_videos_each do |file_name|
        p "Analizzo: #{file_name}"
        comand = "ffmpeg -loglevel panic -n -i #{Rails.root.join('data',
                                                                 file_name)} -map 0:s:#{args[:channel]} #{Rails.root.join('data',
                                                                                                                          file_name_without_extension(file_name))}.srt"
        system(comand)
      end
    end
  end
end
