require 'spec_helper'

describe 'Mobile' do
  it 'handles rotation and portrait-landscape shananigans and gives adequate preview (horizontal)' do
    @video = Video.create(mobile: File.new(Dir.pwd + '/spec/support/rotate.mp4'))
    file = File.open(Dir.pwd + '/spec/dummy/public' + @video.mobile(:shrink).split('?')[0])

    size = ImageSize.new(file.read)

    w = size.w
    h = size.h

    # shrinked down to given size
    w.should <= 640
    h.should <= 640

    # landscape orientation preserved
    w.should > h
  end

  it 'handles rotation and portrait-landscape shananigans and gives adequate preview (vertical)' do
    @video = Video.create(mobile: File.new(Dir.pwd + '/spec/support/vertical.mp4'))
    file = File.open(Dir.pwd + '/spec/dummy/public' + @video.mobile(:shrink).split('?')[0])

    size = ImageSize.new(file.read)

    w = size.w
    h = size.h

    # shrinked down to given size
    w.should <= 640
    h.should <= 640

    # portrait orientation preserved
    h.should > w
  end


  it 'forcing aspect ratio by cropping image with AxB# parameter' do
    @video = Video.create(mobile: File.new(Dir.pwd + '/spec/support/rotate.mp4'))
    file = File.open(Dir.pwd + '/spec/dummy/public' + @video.mobile(:pad).split('?')[0])

    size = ImageSize.new(file.read)

    w = size.w
    h = size.h

    # squared
    w.should == 1080
    h.should == 1080
  end

  it 'forcing aspect ratio by cropping image with AxB# parameter (vertical)' do
    @video = Video.create(mobile: File.new(Dir.pwd + '/spec/support/vertical.mp4'))
    file = File.open(Dir.pwd + '/spec/dummy/public' + @video.mobile(:pad).split('?')[0])

    size = ImageSize.new(file.read)

    w = size.w
    h = size.h

    # squared
    w.should == 1080
    h.should == 1080
  end

  it 'does not enlarge image with AxB# parameter' do
    @video = Video.create(mobile: File.new(Dir.pwd + '/spec/support/rotate.mp4'))
    file = File.open(Dir.pwd + '/spec/dummy/public' + @video.mobile(:xpad).split('?')[0])

    size = ImageSize.new(file.read)

    w = size.w
    h = size.h

    # 1:2
    w.should == 540
    h.should == 1080
  end

  it 'does not enlarge image with AxB# parameter (vertical)' do
    @video = Video.create(mobile: File.new(Dir.pwd + '/spec/support/vertical.mp4'))
    file = File.open(Dir.pwd + '/spec/dummy/public' + @video.mobile(:xpad).split('?')[0])

    size = ImageSize.new(file.read)

    w = size.w
    h = size.h

    # 1:2
    w.should == 960
    h.should == 1920
  end
end