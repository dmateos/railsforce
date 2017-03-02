var Chart = React.createClass({
  componentDidMount() {
    if (this.props.modules) {
      this.props.modules.forEach(function (module) {
        module(Highcharts);
      });
     }
    // Set container which the chart should render to.
    this.chart = new Highcharts[this.props.type || "Chart"](
      this.props.container,
      this.props.options
    );

    this.setupSubscription();
    this.loadExisting();
  },

  loadExisting() {
    var series = this.chart.series[0];
    if(this.props.data) {
      this.props.data.forEach(function(d) {
        series.addPoint(parseFloat(d.y), true, false);
      });
    }
  },

  loadExistingAjax() {
    //todo
  },

  setupSubscription() {
    par = this;
    var series = this.chart.series[0];

    App.messages = App.cable.subscriptions.create(
        { channel: "DataSequenceChannel", graph: this.props.graph_id }, 
      {
      connected() {
      },

      received(data) {
        series.addPoint(parseFloat(data["y"]), true, false);
      },
    });
  },

  //Destroy chart before unmount.
  componentWillUnmount() {
    this.chart.destroy();
  },

  //Create the div which the chart will be rendered to.
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
        data={this.props.data}
        modules={[]}>
      </Chart>
    )
  }
});
