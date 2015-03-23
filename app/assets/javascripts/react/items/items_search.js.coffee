# @cjsx React.DOM

@ItemsSearch = React.createClass
  displayName: 'ItemsSearch'

  getInitialState: ->
    searchLength: 0

  componentDidMount: ->
    @_subscribeToEvents()

  componentWillUnmount: ->
    @_unsubscribeFromEvents()

  _subscribeToEvents: ->
    $(@refs.search.getDOMNode()).on 'keyup', @_handleSearchOnKeyup
    PubSub.subscribe 'resetButton:onClick', ()=>
      @refs.search.getDOMNode().value = ''
      @setState
        searchLength: 0

  _unsubscribeFromEvents: ->
    PubSub.unsubscribe 'resetButton:onClick'

  _handleOnSubmit: (e) ->
    e.preventDefault()

    searchValue = @refs.search.getDOMNode().value.trim()
    @props.onFormSubmit(searchValue)

  _handleSearchOnKeyup: (e) ->
    @setState
      searchLength: $(e.target).val().length

  _itemText: (count) ->
    if count > 1 then 'items' else 'item'

  render: ->
    count = @props.totalCount
    itemText = @_itemText(count)
    overviewTitle = if @props.totalCount > 0 then "#{count} #{itemText} found"

    <div className="filter-wrapper">
      <div className="overview-wrapper">
        <h3>{overviewTitle}</h3>
        &nbsp;
      </div>
      <div className="form-wrapper">
        <form onSubmit={@_handleOnSubmit}>
          {
            if @state.searchLength != 0
              <ResetButton text="Reset filter" styleClass="reset"/>
          }
          <input ref="search" placeholder="Search items..." type="search"/>
        </form>
      </div>
    </div>