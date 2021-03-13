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
  },

  alertmanager+: {
    alertmanager+: {
      spec+: {
        routePrefix: defaults.alertmanagerRoutePrefix,
      },
    },
  },
}
