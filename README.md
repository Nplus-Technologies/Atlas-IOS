
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

## Implement SearchHelper Class

* Using this line to called completion handler and Search a place by passing the input String to inputText
```
  @objc func textFieldDidChange(_ textField: UITextField) {
  
  SearchHelper.shared.getLocation(inputText: textField.text, completion: { predictions in
  
  // predictions are [[String: AnyObject]] values
  // Use your code with predictions
  
    }
  
```
# Step 2. 

### Place ID to be passed while converting to Latitude and Longitude Geocoding

* Using this line to called completion handler and pass the selected Indexpath.row - placeid

```
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLocation(placeid: [indexPath.row].PlaceId, completion: { location in
        
      // location are [String: AnyObject] values
      // Use your code with location to get Latitude and Longitute
    }
```


