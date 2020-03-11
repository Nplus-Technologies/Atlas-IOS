
# Atlas
Alternate for Google Places Search and Geocoding library, with the purpose of using our custom endpoint.

# iOS SearchPlaces
iOS search places search by using APIs

- Language: Swift 5
- Devices: iPhone, iPad
- Frameworks:
  - UIKit

# To get a Git project into your build:

# Step 1. 
Added UI Elements:

  * UITextField
  * UIlabel
  * UITableView
  
```
SearchView - UIView
```
and using UI Elements Need extensions.

# Step 2. 

UIViewController : 

* TableviewCell Register and delegate and datasource
* Add detegates and datasource in UIViewController - Extenstion
```
extension UIViewController : UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell ?? TableViewCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
  }
```

# Step 3.
## Implement SearchHelper Class 

Using this line to called completion handler and Search a place by passing the input String to inputText
```
  @objc func textFieldDidChange(_ textField: UITextField) {
  
  SearchHelper.shared.getLocation(inputText: textField.text ?? "", completion: { predictions in
  
    }
  
```
* Initialize the base url of your endpoint and input text :
```
       url = BaseURL + inputText
```
And below the function to get inputText and completion handler has block of the code to pass the predictions[[String: AnyObject]] value
````
   func getLocation(inputText : String, completion:@escaping ([[String: Any]])->()) {
        completion(predictions)
    }
````

the result will be returned in callback completion: { predictions in
```
  predictions.compactMap({
  
    ... Code .....
    
    return nil
  })
```

# Step 4.
### Place ID to be passed while converting to Latitude and Longitude Geocoding
Using this line to called completion handler and pass the selected Indexpath.row - placeid
```
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLocation(placeid: [indexPath.row].PlaceId, completion: { location in
    }
```

* Initialize the base url of your endpoint and Placeid :
```
 url = BaseURL + placeid
```
And below the function to get Placeid and completion handler has block of the code to pass the predictions[String: AnyObject] value

```
func selectedLocation(placeid : String, completion:@escaping ([String: Any])->()) {
      completion(location)
    }
```
the result will be returned in callback completion: { location in
```
  completion: { location in
            
  })
```

