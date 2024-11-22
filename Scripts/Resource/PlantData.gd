class_name PlantData
extends Resource

@export var plant_type:PlantType
@export var growth_progress:float

@export var days_since_last_watered:int
@export var is_overwatered:bool
@export var is_underwatered:bool


enum PlantHealth {
	WITHER,
	STRUGGLE,
	SURVIVE,
	HEALTHY,
	THRIVE
}

@export var plant_health:int = PlantHealth.SURVIVE

enum SunLightStatus {
	FULL_SHADE,
	PARTIAL_SHADE,
	PARTIAL_SUN,
	FULL_SUN
}

@export var sunlight_status:int = SunLightStatus.FULL_SUN
