#ifndef AMAZONS_H
#define AMAZONS_H

#include <QObject>

class Amazons: public QObject {
    Q_OBJECT

public:
    Amazons();
    ~Amazons() = default;

    Q_INVOKABLE void speak();
};

#endif
