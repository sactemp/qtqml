#ifndef UserMODEL_H
#define UserMODEL_H

#include <QFile>
#include <QtMath>
#include <QVector3D>

class Calculator : public QObject
{
  Q_OBJECT

  Q_PROPERTY(QString path READ path WRITE setPath NOTIFY pathChanged)
  Q_PROPERTY(QVariantList points MEMBER m_points NOTIFY pointsChanged)

public:
  Calculator(QObject *parent = nullptr) { Q_UNUSED(parent) }
    ~Calculator() {}

  QString path() const {
    return m_path;
  }

public slots:
  void setPath(QString path) {
    if(m_path != path)
    {
      m_path = path;
      emit pathChanged();
      QFile file(path);
      QString line;
      if(file.open(QIODevice::ReadOnly | QIODevice::Text)){
        m_points.clear();
        line = file.readLine();
        while (!file.atEnd()) {
          line = file.readLine().trimmed();
          QStringList values = line.split(";");
          // QStringList values = line.split(QRegExp("\\s+"));
          qreal md = values[0].toFloat();
          qreal inc = 90 - values[1].toFloat(),
              cosInc = qCos(qDegreesToRadians(inc)),
              sinInc = qSin(qDegreesToRadians(inc));
          qreal azm = values[2].toFloat(),
              cosAzm = qCos(qDegreesToRadians(azm)),
              sinAzm = qSin(qDegreesToRadians(azm));

          qreal x = md * cosInc * cosAzm, y = md * cosInc * sinAzm, z = md * sinInc;
          QVector3D p(x, y, z);
          m_points.append(p);
        }
        emit pointsChanged();
      }
    }
  }

signals:
  void pathChanged();
  void pointsChanged();

private:
  QString m_path;
  QVariantList m_points;
};

#endif // UserMODEL_H
