# @cjsx React.DOM

@PaginatorLink = React.createClass
  displayName: 'PaginatorLink'
  # Click handler will use it's onPaginatorLinkClick prop to pass 
  # the pageNumber value to it's parent.
  _handleOnClick: (e) ->
    e.preventDefault()
    @props.onPaginatorLinkClick(@props.pageNumber)
  render: ->
    <a href="#" onClick={@_handleOnClick}>&nbsp;</a>