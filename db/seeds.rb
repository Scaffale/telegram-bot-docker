include SentencesHelper

files_to_add = Dir.glob("#{Rails.root}/to_convert/*.srt")
bar = ProgressBar.create(total: files_to_add.count, progress_mark: '#', remainder_mark: '-')
files_to_add.each do |file|
  file_name = file.split('/').last
  file_name = file_name.split('.srt')[0]
  # p "Analizzo: #{file_name}"
  next if Sentence.where(file_name: file_name).exists?

  opened_file = open(file, "r:ISO-8859-1:UTF-8").readlines
  split_sentences(opened_file).each do |sentence_analized|
    Sentence.create(file_name: file_name,
                    file_filter: file_name.split('.').first,
                    end_time: sentence_analized[:time_end],
                    start_time: sentence_analized[:time_start],
                    text: sentence_analized[:sentence])
  end
  bar.increment
end
p 'Seed completed'
