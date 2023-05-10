# ars_documents
A simple documents with item using metadata 


**Instalation**

> ox_inventory/data/items.lua
```lua
	['document'] = {
		label = 'Document',
		consume = 0,
	},
```
> ox_inventory/modules/items/client.lua
```lua
	Item('document', function(data, slot)
		local metadata = slot.metadata

		exports.ars_documents:openDocument(metadata)
	end)
```

![image](https://github.com/Arius-Development/ars_documents/assets/70983185/d80c46fc-7c46-40d0-b059-451caf2ebea6)

![image](https://github.com/Arius-Development/ars_documents/assets/70983185/3531aa43-34b7-4fd3-b4c3-4b95035605f0)
