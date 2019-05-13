#ifndef AMAZONSPLUGIN_H
#define AMAZONSPLUGIN_H

#include <QQmlExtensionPlugin>

class AmazonsPlugin : public QQmlExtensionPlugin {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif
