$ ->
  content = $('#content')    # where to load new content

  isLoadingNextPage = false  # keep from loading two pages at once
  lastLoadAt = null          # when you loaded the last page
  minTimeBetweenPages = 5000 # milliseconds to wait between loading pages
  loadNextPageAt = 50        # pixels above the bottom

  waitedLongEnoughBetweenPages = ->
    return lastLoadAt == null || new Date() - lastLoadAt > minTimeBetweenPages

  approachingBottomOfPage = ->
    return document.documentElement.clientHeight + $(document).scrollTop() == document.body.offsetHeight

  nextPage = ->
    viewMore = $('#view-more') # tag containing the "View More" link
    url = viewMore.find('a').attr('href')

    return if isLoadingNextPage || !url

    viewMore.addClass('loading')
    isLoadingNextPage = true
    lastLoadAt = new Date()

    $.ajax({
      url: url,
      method: 'GET',
      dataType: 'script',
      success: ->
        viewMore.removeClass('loading');
        ReactRailsUJS.mountComponents('#content')
        isLoadingNextPage = false;
        lastLoadAt = new Date();
    })

  # watch the scrollbar
  $(window).scroll ->
    if approachingBottomOfPage()
      nextPage()
      console.log("Loading")
