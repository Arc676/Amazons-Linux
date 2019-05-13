#include <QtQml>
#include <QtQml/QQmlContext>

#include "plugin.h"
#include "amazons.h"

void AmazonsPlugin::registerTypes(const char *uri) {
    //@uri Amazons
    qmlRegisterSingletonType<Amazons>(uri, 1, 0, "Amazons", [](QQmlEngine*, QJSEngine*) -> QObject* { return new Amazons; });
}
