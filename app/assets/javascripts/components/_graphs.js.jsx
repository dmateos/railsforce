var Chart = React.createClass({
  componentDidMount() {
    if (this.props.modules) {
      this.props.modules.forEach(function (module) {
        module(Highcharts);
      });
     }

    this.chart = new Highcharts[this.props.type || "Chart"](
      this.props.container,
      this.props.options
    );

    if(this.props.ajax_path) {
      this.loadExistingAjax();
    }
    this.setupSubscription();
  },

  loadExisting(data) {
    if(data) {
      par = this;
      data.forEach(function(d) {
        var series = par.chart.series[d.series];
        series.addPoint(parseFloat(d.y), false, false);
      });
      this.chart.redraw()
    }
  },

  loadExistingAjax() {
    $.ajax({
      url: this.props.ajax_path,
      dataType: "json",
      cache: false,
      success: function(data) {
        this.loadExisting(data) 
      }.bind(this)
    })
  },

  setupSubscription() {
    par = this;
    App.messages = App.cable.subscriptions.create(
        { channel: "DataSequenceChannel", graph: this.props.graph_id }, 
      {
      connected() {
      },

      received(data) {
        var series = par.chart.series[data.series];
        series.addPoint(parseFloat(data["y"]), true, false);
      },
    });
  },

  componentWillUnmount() {
    this.chart.destroy();
  },

  render() {
    return (
      <div id={this.props.container}> </div>
    )
  }
});

var ChartContainer = React.createClass({
  render() {
    console.log(this.props.options);
    return(
      <Chart 
        container="chart" 
        graph_id={this.props.graph_id}
        options={this.props.options} 
        ajax_path={this.props.ajax_path}
        modules={[]}>
      </Chart>
    )
  }
});
