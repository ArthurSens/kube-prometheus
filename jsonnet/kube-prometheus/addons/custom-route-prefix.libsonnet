local defaults = {
  grafanaRoutePrefix: '/grafana/',
  prometheusRoutePrefix: '/prometheus/',
  alertmanagerRoutePrefix: '/alertmanager/',
};

{
  values+:: {
    grafana+:: {
      config+: {
        sections+: {
          server+: {
            root_url: '%(protocol)s://%(domain)s:%(http_port)s' + defaults.grafanaRoutePrefix,
          },
        },
      },
    },
  },

  prometheus+: {
    prometheus+: {
      spec+: {
        routePrefix: defaults.prometheusRoutePrefix,
      },
    },
    serviceMonitor+: {
      spec+: {
        endpoints: std.map(
          function(e) e {
            path: defaults.prometheusRoutePrefix + 'metrics',
          }
          , super.endpoints
        ),
      },
    },
  },

  alertmanager+: {
    alertmanager+: {
      spec+: {
        routePrefix: defaults.alertmanagerRoutePrefix,
      },
    },

    serviceMonitor+: {
      spec+: {
        endpoints: std.map(
          function(e) e {
            path: defaults.alertmanagerRoutePrefix + 'metrics',
          }
          , super.endpoints
        ),
      },
    },
  },
}
