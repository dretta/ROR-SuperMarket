# @cjsx React.DOM

@ItemsCard = React.createClass
  displayName: 'ItemsCard'
  render: ->
    cx = React.addons.classSet
    cardClasses = cx
      'card': true

    <div className={cardClasses}>
      <header>
        <div className="info-wrapper">
          <h4>{@props.data.name}</h4>
        </div>
      </header>
      <div className="card-body">
        <div className="headline">
          <p>{@props.data.description}</p>
        </div>
        <ul className="contact-info">
          <li>$ {@props.data.price}</li>
        </ul>
      </div>
    </div>