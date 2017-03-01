class ActivityPictureStatus extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      editing: null,
      activity: this.props.activity,
      user: this.props.user,
      picture: this.props.item
    }
  }

  handleStatusUpdate() {
    $.ajax({
      url: "/" + this.props.user.slug + "/albums/" + this.state.picture.album_id + "/pictures/" + this.state.picture.id + ".json",
      dataType: 'json',
      type: "DELETE",
      data: {  },
      success: function(data) {
        this.setState({ item: data });
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  }

  renderItem() {
    return (
      <div key={ this.props.activity.id} className="panel panel-white post panel-shadow">
        <div className="post-heading">
          <div className="pull-left image">
            <img src={ this.props.user.avatar.url } className="avatar" />
          </div>

          <div className="pull-left meta">
            <div className="title h5">
              <a href="#" className="post-user-name">{ this.props.user.first_name } { this.props.user.last_name } </a>
              uploaded picture.
            </div>
            <h6 className="text-muted time">
              <time className="timeago" dateTime={ this.props.activity.created_at }></time>
            </h6>
          </div>

          <div className="btn-group pull-right">
            <i className="fa fa-cog" aria-hidden="true" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></i>
            <ul className="dropdown-menu">
              <li onClick={ this.handleStatusUpdate.bind(this) }><a>Delete</a></li>
            </ul>
          </div>
        </div>

        <div className="post-description status-picture">
          <a href={"/" +this.props.user.slug + "/albums/" + this.state.picture.album_id + "/pictures/" + this.state.picture.id }>
            <img src={ this.state.picture.picture.url } className="img-responsive" />
          </a>
        </div>
      </div>
    )
  }

  render () {
    return (
      this.renderItem()
    )
  }
}

