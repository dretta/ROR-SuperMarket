
@PaginatorSection = React.createClass
  displayName: 'PaginatorSection'
  # Link on click event handler
  _handleOnClick: (pageNumber) ->
    # Uses it's own props as callback, so it's parent component can 
    # handle it and receive the pageNumber value.
    @props.onPaginate(pageNumber)
  render: ->
    # If there is more than 1 page...
    if @props.totalPages > 1
      # Render the links list
      <ul className="pagination">
        {
          for i in [1..@props.totalPages]
            <li key={i}>
              {
                # Different item for current page
                if i == @props.currentPage
                  <span>&nbsp;</span>
                else
                  # PaginatorLink component with a pageNumber prop that will 
                  # used to set the value passed by it's other 
                  # onPaginatorLinkClick prop callback.
                  <PaginatorLink pageNumber={i} onPaginatorLinkClick={@_handleOnClick} />
              }
            </li>
        }
      </ul>
    # ... if one page only or none
    else
      # Remember that the render function has to return always a single node
      <div>&nbsp;</div>