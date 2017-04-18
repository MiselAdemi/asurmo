class ActivityStatus extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      editing: null,
      activity: this.props.activity,
      user: this.props.user,
      to_user: this.props.to_user,
      current_user: this.props.current_user,
      item: this.props.item,
      body: this.props.body
    }
  }

  toggleEditing(itemId) {
    let newState = {}
    newState["editing"] = itemId
    this.setState(newState)
  }

  handleEditField(e) {
    if(e.keyCode === 13) {
      let target = e.target,
        update = {}

      update.id = this.state.editing
      update[target.name] = target.value

      this.handleStatusUpdate(update)
    }
  }

  handleEditItem() {
    let itemId = this.state.editing

    this.handleStatusUpdate({
      id: this.state.item.id,
      body: this.refs[ `status_${ this.state.activity.id }` ].value,
    })
  }

  handleStatusUpdate(update) {
    $.ajax({
      url: location.pathname + "/statuses/" + update.id + ".json",
      dataType: 'json',
      type: "PATCH",
      data: { status: update },
      success: function(data) {
        this.setState({ editing: null });
        this.setState({ item: data });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  renderItemOrEditField() {
    if(this.state.editing === this.props.activity.id) {
      return (
        <div key={ `editing-${ this.props.activity.id }` } className="panel panel-white post panel-shadow">
        <div className="post-heading">
        <div className="pull-left image">
        <img src={ this.props.user.avatar.url } className="avatar" />
        </div>

        <div className="title h5">
        <a href="#" className="post-user-name">{ this.props.user.first_name } { this.props.user.last_name } </a>
        made a post.
          </div>
        <h6 className="text-muted time">
        <time className="timeago" dateTime={ this.props.activity.created_at }></time>
        </h6>
        </div>

        <div className="post-description">
        <textarea onKeyDown={ this.handleEditField.bind(this) } name="body" ref={ `status_${this.props.activity.id }` } defaultValue={ this.state.item.body }></textarea>
        </div>
        <button onClick={ this.handleEditItem.bind(this) } className="btn btn-success">Update</button>
        </div>
      )
    }else {
      return (
        <div key={ this.props.activity.id} className="panel panel-white post panel-shadow">
        <div className="post-heading">
        <div className="pull-left image">
        <img src={ this.props.user.avatar.url } className="avatar" />
        </div>

        <div className="pull-left meta">
        <div className="title h5">
          <a href="#" className="post-user-name">{ this.props.user.first_name } { this.props.user.last_name } </a>

          { this.props.activity.user_id !== this.props.current_user.id &&
            <span>
              &rarr;
              <a href="#" className="post-user-name"> { this.props.to_user.first_name } { this.props.to_user.last_name } </a>
            </span>
          }

          made a post
        </div>

        <h6 className="text-muted time">
        <time className="timeago" dateTime={ this.props.activity.created_at }></time>
        </h6>
        </div>

        <div className="btn-group pull-right">
        <i className="fa fa-cog" aria-hidden="true" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
        <ul className="dropdown-menu">
        <li onClick={ this.toggleEditing.bind(this, this.props.activity.id) }><a>Edit</a></li>
        <li><a href="#">Delete</a></li>
        </ul>
        </div>
        </div>

        <div className="post-description">
        <p dangerouslySetInnerHTML={{__html: this.state.body}}></p>
        </div>
        </div>
      )
    }
  }

  render () {
    return (
      this.renderItemOrEditField()
    )
  }
}
