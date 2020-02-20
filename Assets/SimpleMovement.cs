using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SimpleMovement : MonoBehaviour
{
    // Public Variables
    public float Velocity = 1.0f;
    public float JumpForce = 1.0f;
    // Private Variables
    private Rigidbody _rigidbody;
    private float _horizontalSpeed;
    private float _verticalSpeed;

    // Start is called before the first frame update
    void Start()
    {
        _rigidbody = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        _horizontalSpeed = Input.GetAxis("Horizontal") * Velocity;
        _verticalSpeed = Input.GetAxis("Vertical") * Velocity;
        _rigidbody.AddForce(_horizontalSpeed, 0, _verticalSpeed);
    }

}
