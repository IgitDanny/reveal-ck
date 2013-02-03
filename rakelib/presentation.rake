
DIR_IMAGES_FILES = FileList["images/**/*"]

desc 'Build presentation'
task :presentation => [ 'slides', 'slides.html'] do
  cp 'slides.html', 'slides'
  cp_r REVEAL_FILES, 'slides'
  mkdir_p 'slides/images'
  cp_r DIR_IMAGES_FILES, 'slides/images'
  line_nums = {
    default_slides: {
      first: 37,
      last: 338
    }
  }
  default_slides = line_nums[:default_slides][:first]..line_nums[:default_slides][:last]
  FileSlicer.remove! 'slides/index.html', default_slides
  FileSplicer.insert! 'slides.html', into: 'slides/index.html', after: '<div class="slides">'
end
