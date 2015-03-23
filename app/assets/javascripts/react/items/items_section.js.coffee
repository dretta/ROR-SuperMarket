# @cjsx React.DOM

@ItemsSection = React.createClass
  displayName: 'ItemsSection'

  getInitialState: ->
    didFetchData: false
    items: []
    meta:
      total_pages: 0
      current_page: 1
      total_count: 0
    fetchData:
      search: ''
      page: 1

  componentDidMount: ->
    @_subscribeToEvents()
    @_fetchItems({})

  componentWillUnmount: ->
    @_unsubscribeFromEvents()

  _subscribeToEvents: ->
    PubSub.subscribe 'resetButton:onClick', ()=>
      @state.fetchData =
        search: ''
        page: 1

      @_fetchItems()

  _unsubscribeFromEvents: ->
    PubSub.unsubscribe 'resetButton:onClick'

  _fetchItems: ()->
    $.ajax
      url: Routes.items_path()
      dataType: 'json'
      data: @state.fetchData
    .done @_fetchDataDone
    .fail @_fetchDataFail

  _fetchDataDone: (data, textStatus, jqXHR) ->
    return false unless @isMounted()
    @setState
      didFetchData: true
      items: data.items
      meta: data.meta

  _fetchDataFail: (xhr, status, err) =>
    console.error @props.url, status, err.toString()

  _handleOnSearchSubmit: (search) ->
    @state.fetchData=
      search: search
      page: 1

    @_fetchItems()

  _handleOnPaginate: (pageNumber) ->
    @state.fetchData.page = pageNumber
    @_fetchItems()

  render: ->
    cardsNode = @state.items.map (item) ->
      <ItemCard key={item.id} data={item}/>

    noDataNode =
      <div className="warning">
        <span className="fa-stack">
          <i className="fa fa-meh-o fa-stack-2x"></i>
        </span>
        <h4>No items found...</h4>
        <ResetButton text="Reset filter" styleClass="btn" />
      </div>

    <div>
      <ItemsSearch totalCount={@state.meta.total_count} onFormSubmit={@_handleOnSearchSubmit}/>
      <PaginatorSection totalPages={@state.meta.total_pages} currentPage={@state.meta.current_page} onPaginate={@_handleOnPaginate}/>
      <div className="cards-wrapper">
        {
          if @state.items.length > 0
            {cardsNode}
          else if @state.didFetchData
            {noDataNode}
        }
      </div>
      <PaginatorSection totalPages={@state.meta.total_pages} currentPage={@state.meta.current_page} onPaginate={@_handleOnPaginate}/>
    </div>