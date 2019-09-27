
function getUpperParent(item) {
    if(item.parent)
        return getUpperParent(item.parent);
    return item;
}

function b(str) {
    return ["<b>", str, " ", "</b>"].join("")
}

function field(title, value, spacer) {
  return [b(title), spacer || ': ', value].join("")
}

function chunkString(str, len) {
  var _size = Math.ceil(str.length/len),
      _ret  = new Array(_size),
      _offset
  ;

  for (var _i=0; _i<_size; _i++) {
    _offset = _i * len;
    _ret[_i] = str.substring(_offset, _offset + len);
  }

  return _ret;
}

function createMessageDialog(parent, text) {
  return Qt.createQmlObject('import QtQuick.Dialogs 1.2; MessageDialog { title: "Информация"; text: "' + text + '"; icon: StandardIcon.Information }',
                            parent,
                            "dynamicSnippet1");
}

function createObjectFromComponent(sourceItem, componentFilename, options) {
    if(options === undefined)
        options = {};
    var globalParent = getUpperParent(sourceItem)
    var component = Qt.createComponent(componentFilename)
    if(component.status === Component.Error)
    {
        console.log("DEBUG ERROR", component.errorString())
    }
    options.sourceItem = sourceItem;
    var instance = component.createObject(globalParent, options)
    if(!instance)
        console.log("DEBUG ERROR created object is null")
    return instance;
}

function openPopup(sourceItem, componentFilename, options) {
    if(options === undefined)
        options = {};
    var globalParent = getUpperParent(sourceItem)
    var sourceMargin = sourceItem.mapToItem(globalParent, 0, sourceItem.height)

    options.sourceMargin = sourceMargin;

    return createObjectFromComponent(sourceItem, componentFilename, options)
}

function findByProperty(lst, propertyName, targetObject, targetProperty)
{
    //return lst.filter(function(item) { return item[propertyName]===targetObject[propertyValue]});

    for(var i=0; i<lst.length; i++)
    {
        var obj = lst[i]
        if(propertyName!=="this")
           obj = obj[propertyName]
        //
        if(obj===targetObject[targetProperty])
        {
            //console.log(JSON.stringify(obj), JSON.stringify(targetObject[targetProperty]))
            return lst[i];
        }
    }
    return null;
    //return lst.filter(function(item) { return item[propertyName]===propertyValue});
}

function findIndexByProperty(lst, propertyName, propertyValue)
{
    for(var i=0; i<lst.length; i++)
    {
        var obj = lst[i]
        //if(propertyName!=="this")
        //   obj = obj[propertyName]
        //console.log(1111111, JSON.stringify(lst[i]), propertyName, JSON.stringify(propertyValue))
        if((lst[i]===propertyValue))
        {
            //console.log(22222222, i)
            return i;
        }
    }
    return -1;
}
